import { shallowMount } from "@vue/test-utils"
import PlusButton from "atoms/PlusButton"
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

    wrapper = shallowMount(PlusButton, {
      store,
      propsData: {
        id: 1,
        count: 2,
      },
    })
  })

  it("プラスボタンをクリックするとupdateCountが呼ばれること", () => {
    const button = wrapper.find(".plus-btn")
    expect(button.text()).toMatch("mdi-plus")

    button.vm.$emit("click")
    expect(mutations.updateCount).toBeCalled();
  })
});
