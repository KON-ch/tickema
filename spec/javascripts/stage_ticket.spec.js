import { shallowMount } from "@vue/test-utils"
import StageTicket from "StageTicket";

describe("StageTicket", () => {
  const wrapper = shallowMount(StageTicket, {
    propsData: {
      tickets: [
        {
          contact_id: 1,
          count: 1,
          customer_id: 1,
          customer_name: "テスト タロウ",
          date: "1月1日",
          id: 1,
          schedule_id: 1,
          status: "reserved",
          time: "18:30"
        }
      ]
    }
  });

  it("名前が表示されていること", () => {
    // wrapper.find(".customer-name").toBe("テスト タロウ")
    // selectorを指定した方が厳密だが、テストが壊れやすくなる
    expect(wrapper.text()).toMatch("テスト タロウ")
  });

  it("予約日が表示されていること", () => {
    expect(wrapper.text()).toMatch("1月1日")
  });

  it("予約時間が表示されていること", () => {
    expect(wrapper.text()).toMatch("18:30")
  });

  it("予約ステータスが表示されていること", () => {
    expect(wrapper.text()).toMatch("予約済み")
  });
})
