import { shallowMount } from "@vue/test-utils"
import UserPage from "UserPage"

jest.mock("axios", () => ({
  get: jest.fn(() => Promise.resolve(
    {
      data: {
        name: "テスト タロウ",
        stages: [{ id: 1, title: "サンプル・デビュー" }]
      }
    }
  ))
}))

describe("props", () => {
  const wrapper = shallowMount(UserPage, { stubs: ["router-link"] })

  it("ユーザー名が表示されていること", () => {
    expect(wrapper.find(".user-name").text()).toMatch("テスト タロウ")
  })
  it("公演タイトルが表示されていること", () => {
    expect(wrapper.find(".my-stage_link").text()).toMatch("サンプル・デビュー")
  })
})
