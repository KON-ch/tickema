import { shallowMount, mount } from "@vue/test-utils"
import CustomerIndex from "CustomerIndex"
import Vuetify from "vuetify"
import Vuex from "vuex"

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

    expect(CustomerIndex.computed.searchCustomers.call(localThis)).toEqual(
      [{ name: "テスト タロウ" }]
    )
  });

  it("未入力の場合は全ての顧客を取得すること", () => {
    const localThis = {
      customers: customers_data,
      keyword: ""
    }

    expect(CustomerIndex.computed.searchCustomers.call(localThis)).toEqual(
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
    expect(CustomerIndex.computed.searchCustomers.call(localThis)).toEqual([])
  });
});

jest.mock("axios", () => ({
  get: jest.fn(() => Promise.resolve({ data: [{ id: 1, name: "テスト タロウ" }] })),
  put: jest.fn(() => Promise.resolve())
}))

describe("formColor", () => {
  let mutations
  let store
  let wrapper

  beforeEach(() => {
    mutations = { fetchStages: jest.fn() }

    store = new Vuex.Store({
      state: { stages: [] },
      mutations
    })

    wrapper = shallowMount(CustomerIndex, { store })
  })

  it("待機状態は色が白色であること", () => {
    wrapper.setData({ editable: { customer_1: false } })
    expect(wrapper.vm.formColor(1)).toBe("white")
  });

  it("入力状態は色が#FCE4ECであること", () => {
    wrapper.setData({ editable: { customer_1: true } })
    expect(wrapper.vm.formColor(1)).toBe("#FCE4EC")
  })
})

describe("updateName", () => {
  let mutations
  let store
  let wrapper

  beforeEach(() => {
    mutations = { fetchStages: jest.fn() }

    store = new Vuex.Store({
      state: { stages: [] },
      mutations
    })

    wrapper = wrapper = mount(CustomerIndex, {
      vuetify: new Vuetify(),
      store,
      stubs: ["router-link"],
    })
  })

  it("顧客名が更新されること", async () => {
    expect(wrapper.vm.customers).toEqual([{ id: 1, name: "テスト タロウ" }])
    const form = wrapper.find(".edit-form__name")
    form.vm.$emit("input", "テスト たろう")
    wrapper.find(".save-btn__btn").trigger("click")
    await wrapper.vm.$nextTick()

    expect(wrapper.vm.customers).toEqual([{ id: 1, name: "テスト たろう" }])
  })
})

describe("switchEditbale", () => {
  let mutations
  let store
  let wrapper

  beforeEach(() => {
    mutations = { fetchStages: jest.fn() }

    store = new Vuex.Store({
      state: { stages: [] },
      mutations
    })

    wrapper = wrapper = mount(CustomerIndex, {
      vuetify: new Vuetify(),
      store,
      stubs: ["router-link"],
    })
  })

  it("待機状態の場合は編集可能となること", () => {
    wrapper.setData({ editable: { customer_1: false } })
    const button = wrapper.find(".edit-btn__btn")
    button.trigger("click")
    expect(wrapper.vm.editable).toEqual({ customer_1: true })
  })

  it("編集可能の場合は待機状態となること", () => {
    wrapper.setData({ editable: { customer_1: true } })
    const button = wrapper.find(".edit-btn__btn")
    button.trigger("click")
    expect(wrapper.vm.editable).toEqual({ customer_1: false })
  })
})
