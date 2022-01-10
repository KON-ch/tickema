import { shallowMount, mount } from "@vue/test-utils"
import CountTicket from "CountTicket"
import Vuetify from "vuetify";

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
  put: jest.fn(() => Promise.resolve()),
  delete: jest.fn(() => Promise.resolve())
}))

describe("updateCount", () => {
  const wrapper = shallowMount(CountTicket, {
    propsData: {
      id: 1,
      count: 2,
      tickets: [
        {
          id: 1,
          count: 2,
        }
      ]
    },
  })

  it("枚数が加算されること", () => {
    const button = wrapper.find(".plus-btn")
    expect(button.text()).toMatch("mdi-plus")

    button.vm.$emit("click")
    const result = wrapper.props().tickets.find( ticket => ticket.id == 1 ).count
    expect(result).toBe(3)
  })

  it("枚数が減算されること", () => {
    const button = wrapper.find(".minus-btn")
    expect(button.text()).toMatch("mdi-minus")

    button.vm.$emit("click")
    const result = wrapper.props().tickets.find( ticket => ticket.id == 1 ).count
    expect(result).toBe(1)
  })
});

describe("deleteTicket", () => {
  const wrapper = mount(CountTicket, {
    // mountで子コンポーネントをレンダリングするとVIcon(vuetify)でエラーとなる
    vuetify: new Vuetify(),
    propsData: {
      id: 1,
      showModal: false,
      deleteTarget: -1,
      tickets: [
        { id: 1 }
      ]
    },
  })

  it("チケットが削除されること", async () => {
    expect(wrapper.props().tickets).toEqual([{ id: 1 }])
    await wrapper.find(".trash-btn").trigger("click")
    wrapper.find(".ok-btn").trigger("click")
    expect(wrapper.props().tickets).toEqual([])
  })
});
