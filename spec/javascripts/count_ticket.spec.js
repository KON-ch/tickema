import { shallowMount, mount } from "@vue/test-utils"
import CountTicket from "CountTicket"
import Vuetify from "vuetify";
import Vuex from "vuex"

describe("props", () => {
  const wrapper = shallowMount(CountTicket, {
    propsData: {
      count: 1
    }
  });

  it("予約枚数が表示されていること", () => {
    expect(wrapper.text()).toMatch("1枚")
  });
});

// describeの前に設定する必要がある
// 複数回設定すると最後しか適用されない為、一度に設定する
jest.mock("axios", () => ({
  patch: jest.fn(() => Promise.resolve()),
  delete: jest.fn(() => Promise.resolve())
}))

describe("updateCount", () => {
  let store
  let mutations
  let wrapper

  beforeEach(() => {
    mutations = { updateCount: jest.fn() }

    store = new Vuex.Store({
      state: { tickets: [{ id: 1, count: 2 }] },
      mutations
    })

    wrapper = shallowMount(CountTicket, {
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

  it("マイナスボタンをクリックするとupdateCountが呼ばれること", () => {
    const button = wrapper.find(".minus-btn")
    expect(button.text()).toMatch("mdi-minus")

    button.vm.$emit("click")
    expect(mutations.updateCount).toBeCalled();
  })
});

describe("deleteTicket", () => {
  let store
  let mutations
  let wrapper

  beforeEach(() => {
    mutations = { deleteTicket: jest.fn() }

    store = new Vuex.Store({
      state: { tickets: [{ id: 1 }] },
      mutations
    })

    wrapper = mount(CountTicket, {
      // mountで子コンポーネントをレンダリングするとVIcon(vuetify)でエラーとなる
      vuetify: new Vuetify(),
      store,
      propsData: {
        id: 1,
        showModal: false,
        deleteTarget: -1,
      },
    })
  })

  it("削除ボタンをクリックするとdeleteTicketが呼ばれること", async () => {
    await wrapper.find(".trash-btn").trigger("click")
    wrapper.find(".ok-btn").trigger("click")
    expect(mutations.deleteTicket).toBeCalled();
  })
});
