import { shallowMount } from "@vue/test-utils"
import UserMenu from "UserMenu"
import Vuetify from "vuetify"
import Vuex from "vuex"

describe("props", () => {
  let store
  let wrapper

  beforeEach(() => {
    store = new Vuex.Store({
      state: { stages: [{ id: 1, title: "サンプル・デビュー" }] }
    })

    wrapper = shallowMount(UserMenu, {
      vuetify: new Vuetify(),
      stubs: ["router-link"],
      store
    })
  });

  it("タイトルが表示されていること", () => {
    expect(wrapper.text()).toMatch("サンプル・デビュー")
  })
})
