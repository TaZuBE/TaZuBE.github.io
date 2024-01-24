<template>
  <test class="center" :powerless-color="'#FB1'" :tip-color="'pink'"></test>
  <div class="box"></div>
</template>

<script lang = "ts">
  import test from "./test.vue";
  export default {
    components: {
      test
    },
    methods: {
      handleDown() {
        console.log('handleDown');
      },
      handleUp() {
        console.log('handleUp');
      },
      handleMove() {
        console.log('handleMove');
      },
      mouseIsOverHandle(isOver: boolean) {
        console.log(isOver);
      }
    }
  }
</script>

<style scoped>
  .center {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
  }
</style>