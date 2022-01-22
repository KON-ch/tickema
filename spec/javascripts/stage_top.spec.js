import { shallowMount } from "@vue/test-utils"
import StageTop from "StageTop"
import Vuex from "vuex"

describe("searchTickets", () => {
  // 入力が合った場合はstore/gettersのテストとする
  it("未入力の場合は空の配列が返ること", () => {
    const localThis = {
      tickets: [
        { customer_name: "テスト タロウ" },
        { customer_name: "テスト ジロウ" }
      ],
      keyword: ""
    }

    expect(StageTop.computed.searchTickets.call(localThis)).toEqual([])
  });
})

describe("setScheduleColor", () => {
  let store
  let wrapper
  let getters

  beforeEach(() => {
    getters = {
      searchTickets: () => [],
      totalCount: () => []
    }
    store = new Vuex.Store({
      state: { tickets: [] },
      getters
    })

    wrapper = shallowMount(StageTop, { store })
  });

  it("15時より前の場合はmatineeとなること", () => {
    expect(wrapper.vm.setScheduleColor("14:59")).toBe("schedule-matinee")
  });

  it("15時以降の場合はsoireeとなること", () => {
    expect(wrapper.vm.setScheduleColor("15:00")).toBe("schedule-soiree")
  });
});

describe("countRank", () => {
  let store
  let wrapper
  let getters

  beforeEach(() => {
    getters = {
      searchTickets: () => [],
      totalCount: () => []
    }
    store = new Vuex.Store({
      state: { tickets: [] },
      getters
    })

    wrapper = shallowMount(StageTop, { store })
  });

  it("10未満の場合はノーランクとなること", () => {
    expect(wrapper.vm.countRank(9)).toBe("")
  });

  it("20未満の場合はsilverランクとなること", () => {
    expect(wrapper.vm.countRank(19)).toBe("count-rank_silver")
  });

  it("30未満の場合はgoldランクとなること", () => {
    expect(wrapper.vm.countRank(29)).toBe("count-rank_gold")
  });

  it("50未満の場合はplatinumランクとなること", () => {
    expect(wrapper.vm.countRank(49)).toBe("count-rank_platinum")
  });

  it("50以上の場合はdiamondランクとなること", () => {
    expect(wrapper.vm.countRank(50)).toBe("count-rank_diamond")
  });
})
