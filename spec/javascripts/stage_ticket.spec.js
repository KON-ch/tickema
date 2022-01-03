import { shallowMount } from "@vue/test-utils"
import StageTicket from "StageTicket";

describe("props", () => {
  const wrapper = shallowMount(StageTicket, {
    propsData: {
      tickets: [
        {
          customer_name: "テスト タロウ",
          date: "1月1日",
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
});

describe("setStatusColor", () => {
  const wrapper = shallowMount(StageTicket)

  it("予約ステータスの色に変換されること", () => {
    // StageTicket.computed.setStatusColor()では、引数を渡したテストができない
    expect(wrapper.vm.setStatusColor("reserved")).toBe("indigo")
    expect(wrapper.vm.setStatusColor("applied")).toBe("amber")
    expect(wrapper.vm.setStatusColor("notified")).toBe("red")
    expect(wrapper.vm.setStatusColor("finished")).toBe("teal")
  });
})

describe("searchTickets", () => {
  const tickets_data = [
    { customer_name: "テスト タロウ" },
    { customer_name: "テスト ジロウ" },
  ]
  it("一致する顧客名が取得できること", () => {
    const localThis = {
      tickets: tickets_data,
      keyword: "テスト タロウ"
    }

    // toBe()ではオブジェクトまたは配列の値を確認できない
    expect(StageTicket.computed.searchTickets.call(localThis)).toEqual(
      [
        { customer_name: "テスト タロウ" }
      ]
    )
  });

  it("未入力の場合は全ての顧客を取得すること", () => {
    const localThis = {
      tickets: tickets_data,
      keyword: ""
    }

    expect(StageTicket.computed.searchTickets.call(localThis)).toEqual(
      [
        { customer_name: "テスト タロウ" },
        { customer_name: "テスト ジロウ" }
      ]
    )
  });

  it("一致しない場合は場合は空の配列が返ること", () => {
    const localThis = {
      tickets: tickets_data,
      keyword: "ジェスト"
    }

    expect(StageTicket.computed.searchTickets.call(localThis)).toEqual([])
  });
})
