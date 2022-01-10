import { shallowMount } from "@vue/test-utils"
import CreateCustomer from "CreateCustomer"

jest.mock("axios", () => ({
  post: jest.fn(() => Promise.resolve(
    {
      data: {
        id: 1,
        customer_name: "テスト 太郎"
      }
    }
  ))
}))

describe("createCustomer", () => {
  const $route = { params: 1 }
  const $router = []

  const wrapper = shallowMount(CreateCustomer, {
    mocks: {
      $route,
      $router
    },
    propsData: {
      id: 1, // stage_id
      schedule_id: 1,
      tickets: [],
    }
  });

  it("新しい顧客が登録されること", async () => {
    // v-modelの場合inputへの設定をsetValue()で行えない
    wrapper.find(".form-last_name").vm.$emit("input", "テスト")
    wrapper.find(".form-first_name").vm.$emit("input", "太郎")

    expect(wrapper.vm.lastName).toBe("テスト")
    expect(wrapper.vm.firstName).toBe("太郎")

    expect(wrapper.props().tickets).toEqual([])

    // clickイベントで発火されない為、直接メソッドを呼び出している
    // todo: #1 wrapper.find(".create-btn").trigger("click") のような呼び出しにする
    wrapper.vm.createCustomer()
    await wrapper.vm.$nextTick()
    expect(wrapper.props().tickets).toEqual([{ id: 1, customer_name: "テスト 太郎" }])
  });
});
