<template>
  <div class="line" ref="line" @mousedown="MouseDown" :style="{
    width: lineWidth + 'px',
    height: lineHeight + 'px',
    backgroundColor: powerlessColor,
    borderRadius: lineHeight / 2 + 'px',
    cursor: 'pointer'
  }">
    <div class="power" :style="{
      width: percentage * lineWidth / 100 + 'px',
      height: lineHeight + 'px',
      backgroundColor: powerColor,
      borderRadius: lineHeight / 2 + 'px'
    }"></div>
    <div class="handle" @mouseover="setTip(true)" @mouseleave="setTip(false)" :style="{
      width: handleSize + 'px',
      height: handleSize + 'px',
      backgroundColor: 'white',
      border: '1px solid #ccc',
      borderRadius: '50%',
      transform: 'translate(-50%, -50%)',
      position: 'absolute',
      top: '50%',
      left: percentage * lineWidth / 100 + 'px'
    }"></div>
    <div class="tip" :style="{
      position: 'absolute',
      top: `${tipVisible ? '-5px' : '2px'}`,
      left: percentage * lineWidth / 100 + 'px',
      userSelect: 'none',
      opacity: `${tipVisible ? 1 : 0}`,
      transition: 'opacity 0.4s, top 0.4s',
      cursor: 'default'
    }">
      <div class="body" :style="{
        backgroundColor: tipColor,
        padding: '3px',
        color: 'white',
        borderRadius: '15%',
        position: 'absolute',
        transform: `translate(-50%, calc(-100% - 9px))`,
      }">{{ toVal }}</div>
      <div class="tail" :style="{
        width: '15px',
        height: '10px',
        backgroundColor: tipColor,
        position: 'absolute',
        left: '50%',
        top: '-13px',
        transform: 'translate(-50%, 0)',
        clipPath: 'polygon(0% 0%, 50% 80%, 100% 0%)',
      }"></div>
    </div>
  </div>
</template>

<script lang="ts">
  import { defineComponent, ref } from 'vue';
  export default defineComponent ({
    name: 'slider',
    props: {
      lineWidth: {
        type: Number,
        default: 300
      },
      lineHeight: {
        type: Number,
        default: 8
      },
      handleSize: {
        type: Number,
        default: 14
      },
      powerColor: {
        type: String,
        default: 'deepskyblue'
      },
      powerlessColor: {
        type: String,
        default: 'lightgrey'
      },
      defaultpercentage: {
        type: Number,
        default: 50
      },
      tip: {
        type: Boolean,
        default: true
      },
      tipColor: {
        type: String,
        default: 'RGB(30, 144, 255)'
      },
      tipSize: {
        type: Number,
        default: 30
      },
      tipTxtColor: {
        type: String,
        default: 'white'
      },
      lowVal: {
        type: Number,
        default: 0
      },
      upVal: {
        type: Number,
        default: 100
      }
    },
    emits: [
      'handle-down', 
      'handle-up', 
      'handle-move', 
      'mouse-is-over-handle'
    ],
    data() {
      return {
        percentage: ref(this.defaultpercentage),
        lineLeftEnd: 0,
        mouseOverHandle: false,
        handleMoving: false
      };
    },
    computed: {
      toVal(): number {
        return Math.floor(this.percentage / 100 * (this.upVal - this.lowVal) + this.lowVal);
      },
      tipVisible(): boolean {
        return this.handleMoving || this.mouseOverHandle;
      }
    },
    methods: {
      MouseDown(event: MouseEvent) {
        this.handleMoving = true;
        window.addEventListener('mouseup', this.MouseUp);
        window.addEventListener('mousemove', this.MouseMove);
        this.lineLeftEnd = (this.$refs.line as HTMLDivElement).getBoundingClientRect().left;
        this.update(event.clientX);
        this.$emit('handle-down');
      },
      MouseMove(event: MouseEvent) {
        this.update(event.clientX);
      },
      MouseUp() {
        window.removeEventListener('mouseup', this.MouseUp);
        window.removeEventListener('mousemove', this.MouseMove);
        this.handleMoving = false;
        this.$emit('handle-up');
      },
      update(clientX: number) {
        this.percentage = Math.max(Math.min((clientX - this.lineLeftEnd) / (this.lineWidth / 100), 100), 0);
        this.$emit('handle-move', this.toVal);
      },
      setTip(isOver: boolean) {
        this.mouseOverHandle = isOver;
        this.$emit('mouse-is-over-handle', isOver);
      }
    }
  });
</script>

