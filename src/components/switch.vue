<template>
  <div class="switch" :class="{ 'is-on': isOn }" @click="toggle">
    <div class="handle" :class="{ 'is-on': isOn }"></div>
  </div>
</template>

<script lang="ts">
  import { defineComponent } from 'vue';
  export default defineComponent ({
    data() {
      return {
        isOn: false
      };
    },
    methods: {
      toggle() {
        this.isOn = !this.isOn;
      }
    }
  });
</script>

<style scoped>
  .switch {
    width: 60px;
    height: 30px;
    background-color: #ccc;
    border-radius: 15px;
    position: absolute;
    left: 200px;
    top: 200px;
    transition: background-color 0.3s;
  }

  .switch.is-on {
    background-color: lightblue;
  }

  .handle {
    width: 25px;
    height: 25px;
    background-color: white;
    border-radius: 12.5px;
    position: absolute;
    left: 2.5px;
    top: 2.5px;
    transition: left 0.3s, background-color 0.3s;
  }

  .handle.is-on {
    left: 32.5px;
    background-color: orange;
  }
</style>