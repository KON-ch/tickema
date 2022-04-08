import { shallowMount } from "@vue/test-utils"
import MinusButton from "atoms/MinusButton"
import Vuex from "vuex"

describe("minusCount", () => {
  let store
  let mutations
  let wrapper

  beforeEach(() => {
    mutations = { updateCount: jest.fn() }

    store = new Vuex.Store({
      state: { tickets: [{ id: 1, count: 2 }] },
      mutations
    })

    wrapper = shallowMount(MinusButton, {
      store,
      propsData: {
        id: 1,
        count: 2,
      },
    })
  })

  it("マイナスボタンをクリックするとupdateCountが呼ばれること", () => {
    const button = wrapper.find(".minus-btn")
    expect(button.text()).toMatch("mdi-minus")

    button.vm.$emit("click")
    expect(mutations.updateCount).toBeCalled();
  })
});
