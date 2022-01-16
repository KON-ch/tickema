import { shallowMount } from "@vue/test-utils"
import StageSchedule from "StageSchedule"

describe("props", () => {
  const wrapper = shallowMount(StageSchedule, {
    propsData: {
      id: 1,
      schedule_id: 1,
      tickets: [{ schedule_id: 1, customer_name: "テスト タロウ" }],
    }
  })

  it("顧客名が表示されていること", () => {
    expect(wrapper.text()).toMatch("テスト タロウ")
  })
})
