import { shallowMount } from "@vue/test-utils"
import StageSchedule from "StageSchedule"
import Vuex from "vuex"

describe("props", () => {
  let store
  let wrapper

  beforeEach(() => {
    store = new Vuex.Store({
      state: { tickets: [{ schedule_id: 1, customer_name: "テスト タロウ" }] }
    })

    wrapper = shallowMount(StageSchedule, {
      store,
      propsData: {
        schedule_id: 1
      }
    })
  })

  it("顧客名が表示されていること", () => {
    expect(wrapper.text()).toMatch("テスト タロウ")
  })
})
