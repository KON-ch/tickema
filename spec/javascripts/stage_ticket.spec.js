import { shallowMount } from "@vue/test-utils"
import StageTicket from "StageTicket";
import Vuex from "vuex"

describe("props", () => {
  let store
  let wrapper

  beforeEach(() => {
    store = new Vuex.Store({
      state: { tickets: [
        {
          customer_name: "テスト タロウ",
          date: "1月1日",
          status: "reserved",
          time: "18:30"
        }
      ] },
    })

    wrapper = shallowMount(StageTicket, { store })
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
  let store
  let wrapper

  beforeEach(() => {
    store = new Vuex.Store({
      state: { tickets: [] },
    })

    wrapper = shallowMount(StageTicket, { store })
  });

  it("予約ステータスの色に変換されること", () => {
    // StageTicket.computed.setStatusColor()では、引数を渡したテストができない
    expect(wrapper.vm.setStatusColor("reserved")).toBe("indigo")
    expect(wrapper.vm.setStatusColor("applied")).toBe("amber")
    expect(wrapper.vm.setStatusColor("notified")).toBe("red")
    expect(wrapper.vm.setStatusColor("finished")).toBe("teal")
  });
})

describe("searchTickets", () => {
  // 入力があった場合はstore/gettersのテストとする
  it("未入力の場合は顧客名が表示されていること", () => {
    const localThis = {
      tickets: [
        { customer_name: "テスト タロウ"},
        { customer_name: "テスト ジロウ"}
      ],
      keyword: ""
    }

    expect(StageTicket.computed.searchTickets.call(localThis)).toEqual(
      [
        { customer_name: "テスト タロウ" },
        { customer_name: "テスト ジロウ" }
      ]
    )
  });
});

// describeの前に設定する必要がある
jest.mock("axios", () => ({
  put: jest.fn(() => Promise.resolve({ data: "applied" }))
}))

describe("updateStatus", () => {
  let store
  let wrapper
  let mutations

  beforeEach(() => {
    mutations = { updateStatus: jest.fn() }

    store = new Vuex.Store({
      state: { tickets: [
        {
          contact_id: 1,
          customer_name: "テスト タロウ",
          status: "reserved",
        }
      ] },
      mutations,
    })

    wrapper = shallowMount(StageTicket, { store })
  });

  it("ステータスをクリックするとupdateStatusが呼ばれること", async () => {
    await wrapper.find(".status-btn").trigger("click")
    expect(mutations.updateStatus).toBeCalled();
  })
});
