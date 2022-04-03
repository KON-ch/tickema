import { shallowMount } from "@vue/test-utils"
import StageMain from "StageMain"
import Vuex from "vuex"

jest.mock("axios", () => ({
  get: jest.fn(() => Promise.resolve(
    {
      data: {
        id: 1,
        title: "サンプル・デビュー"
      }
    }
  )),
  defaults: {
    headers: {
      common: {}
    }
  }
}))

describe("props", () => {
  const $route = { params: 1 }

  let mutations
  let store
  let wrapper

  beforeEach(() => {
    mutations = { fetchStagesInfo: jest.fn() }

    store = new Vuex.Store({
      state: { title: "サンプル・デビュー" },
      mutations
    })

    wrapper = wrapper = shallowMount(StageMain, {
      store,
      mocks: {
        $route
      }
    })
  })

  it("タイトルが表示されていること", () => {
    expect(wrapper.find(".stage-title").text()).toBe("サンプル・デビュー")
  })
});
