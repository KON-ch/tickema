import { shallowMount, mount } from "@vue/test-utils"
import StageUnbooked from "StageUnbooked"
import Vuetify from "vuetify"

describe("searchCustomers", () => {
  const customers_data = [
    { name: "テスト タロウ" },
    { name: "テスト ジロウ" }
  ]

  it("一致する顧客名が取得できること", () => {
    const localThis = {
      customers: customers_data,
      keyword: "テスト タロウ"
    }

    expect(StageUnbooked.computed.searchCustomers.call(localThis)).toEqual(
      [{ name: "テスト タロウ" }]
    )
  });

  it("未入力の場合は全ての顧客を取得すること", () => {
    const localThis = {
      customers: customers_data,
      keyword: ""
    }

    expect(StageUnbooked.computed.searchCustomers.call(localThis)).toEqual(
      [
        { name: "テスト タロウ" },
        { name: "テスト ジロウ" }
      ]
    )
  });

  it("一致しない場合は場合は空の配列が返ること", () => {
    const localThis = {
      customers: customers_data,
      keyword: "てすと いない"
    }
    expect(StageUnbooked.computed.searchCustomers.call(localThis)).toEqual([])
  });
});

jest.mock("axios", () => ({
  post: jest.fn(() => Promise.resolve(
    {
      data: {
        id: 1,
        name: "テスト タロウ"
      }
    }
  ))
}));

describe("createTicket", () => {
  it("顧客が登録されること", async () => {
    const wrapper = mount(StageUnbooked, {
      vuetify: new Vuetify(),
      propsData: {
        customers: [
          { id: 1, name: "テスト タロウ" }
        ],
        tickets: []
      }
    });

    wrapper.find("#input-6").setValue(1)
    wrapper.find("#input-11").setValue(1)

    expect(wrapper.vm.scheduleIds).toEqual({ schedule_1: "1" })
    expect(wrapper.vm.ticketsCount).toEqual({ count_1: "1" })

    expect(wrapper.props().tickets).toEqual([])
    expect(wrapper.props().customers).toEqual([{ id: 1, name: "テスト タロウ" }])

    wrapper.find(".reserved-btn_content").trigger("click")
    await wrapper.vm.$nextTick()

    expect(wrapper.props().tickets).toEqual([{ id: 1, name: "テスト タロウ" }])
    expect(wrapper.props().customers).toEqual([])
  })
})
