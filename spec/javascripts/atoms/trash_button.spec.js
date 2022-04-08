// <modal>を呼ぶ必要がある為、mountしている
import { mount } from "@vue/test-utils"

import TrashButton from "atoms/TrashButton"
import Vuetify from "vuetify";
import Vuex from "vuex"

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

    wrapper = mount(TrashButton, {
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
    await wrapper.find("button").trigger("click")
    wrapper.find(".ok-btn").trigger("click")
    expect(mutations.deleteTicket).toBeCalled();
  })
});
