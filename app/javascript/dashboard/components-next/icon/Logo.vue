<script setup>
import { useAttrs } from 'vue';
import { useMapGetter } from 'dashboard/composables/store';

const attrs = useAttrs();
const globalConfig = useMapGetter('globalConfig/get');
</script>

<template>
  <img
    v-bind="attrs"
    src="https://megapisos.net.br/wp-content/uploads/2021/11/Logo-s-fundo-1.png"
  />
</template>
