import { shallowMount } from "@vue/test-utils"
import StageMain from "StageMain"

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
  const wrapper = shallowMount(StageMain, {
    mocks: {
      $route
    }
  })

  it("タイトルが表示されていること", () => {
    expect(wrapper.find(".stage-title").text()).toBe("サンプル・デビュー")
  })
});
