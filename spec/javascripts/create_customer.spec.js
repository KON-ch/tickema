import { mount } from "@vue/test-utils"
import CreateCustomer from "CreateCustomer"
import Vuetify from "vuetify"
import Vuex from "vuex"

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
  let mutations
  let store
  let wrapper

  beforeEach(() => {
    mutations = { addTicket: jest.fn() }

    store = new Vuex.Store({
      state: { tickets: [] },
      mutations
    })

    // shallowMount()ではパスしない
    wrapper = mount(CreateCustomer, {
      mocks: {
        $route,
        $router
      },
      vuetify: new Vuetify(),
      store,
      attachTo: document.body,
      propsData: {
        id: 1, // stage_id
        schedule_id: 1,
      }
    })

    // Error: Not implemented: HTMLFormElement.prototype.submit の回避
    // https://github-com.translate.goog/jsdom/jsdom/issues/1937?_x_tr_sl=en&_x_tr_tl=ja&_x_tr_hl=ja&_x_tr_pto=op,sc#issuecomment-526162324
    window._virtualConsole.emit = jest.fn();
  });

  it("登録ボタンでaddTicketが呼ばれること", async () => {
    // v-modelの場合inputへの設定をsetValue()で行えない
    wrapper.find(".form-last_name").vm.$emit("input", "テスト")
    wrapper.find(".form-first_name").vm.$emit("input", "太郎")

    expect(wrapper.vm.lastName).toBe("テスト")
    expect(wrapper.vm.firstName).toBe("太郎")

    wrapper.find(".create-btn").trigger("click")
    await wrapper.vm.$nextTick()

    expect(mutations.addTicket).toBeCalled();

    // attachTo: document.bodyの設定と合わせて定義する
    // https://vue-test-utils.vuejs.org/api/options.html#attachto
    wrapper.destroy()
  });
});
