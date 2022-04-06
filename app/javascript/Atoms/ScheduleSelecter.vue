<template>
  <v-select
    @input="item => $emit('input', item)"
    :value="value"
    :items="schedules"
    :item-text="schedule => schedule.staged_on + ' ' + schedule.staged_at"
    item-value="id"
    background-color="white"
    dense
    flat
    label="公演日時"
    solo
  />
</template>

<script>
  import { mapState } from 'vuex';
  export default {
    props: {
      value: {
        type: Number,
        default: 1
      }
    },
    computed: {
      ...mapState(["id", "schedules"])
    }
  }
</script>
