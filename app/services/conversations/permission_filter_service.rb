class Conversations::PermissionFilterService
  attr_reader :conversations, :user, :account

  def initialize(conversations, user, account)
    @conversations = conversations
    @user = user
    @account = account
  end

  def perform
    return conversations if user_role == 'administrator'

    accessible_conversations
  end

  private
  def accessible_conversations
    team_ids = user.team_ids.presence || [0] # Fallback to prevent invalid SQL if no teams

    conversations.where(inbox: user.inboxes.where(account_id: account.id))
                 .where('assignee_id = ? OR (team_id IN (?) AND assignee_id IS NULL)', user.id, team_ids)
  end

  def account_user
    AccountUser.find_by(account_id: account.id, user_id: user.id)
  end

  def user_role
    account_user&.role
  end
end

Conversations::PermissionFilterService.prepend_mod_with('Conversations::PermissionFilterService')
