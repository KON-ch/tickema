import { shallowMount } from "@vue/test-utils"
import UserMenu from "UserMenu"
import Vuetify from "vuetify"

describe("props", () => {
  const wrapper = shallowMount(UserMenu, {
    vuetify: new Vuetify(),
    stubs: ["router-link"],
    propsData: {
      stages: [{ id: 1, title: "サンプル・デビュー" }],
    }
  })

  it("タイトルが表示されていること", () => {
    expect(wrapper.text()).toMatch("サンプル・デビュー")
  })
})
