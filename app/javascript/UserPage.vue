<template>
  <div id="app">
    <div class="message">
      <span class="user-name">{{ name }}さん</span><br>
      公演を選択してください。
    </div>
    <router-link
      :to="{ name: 'StageMain', params: { id: stage.id } }"
      v-for="stage in stages"
      :key="stage.id"
      class="my-stage"
    >
      <v-card
        class="my-stage_link"
      >
        {{ stage.title }}
      </v-card>
    </router-link>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      stages: [],
      name: ""
    }
  },

  mounted() {
    axios.get(`/mypage`).then(response => {
      this.stages = response.data.stages
      this.name = response.data.name
    })
  },
}
</script>

<style scoped>
.message {
  font-weight: bold;
  text-align: center;
  margin-top: 3rem;
  color: gray;
}

.user-name {
  font-size: 1.5rem;
  color: darkorange;
}

.my-stage {
  text-align: center;
  text-decoration: none;
  padding: 1rem;
}

.my-stage_link {
  font-size: 1.5rem;
  font-weight: bold;
  margin: 0.5rem 1rem 0;
  padding: 1rem 0;
}
</style>
