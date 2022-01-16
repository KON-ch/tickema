import { shallowMount } from "@vue/test-utils"
import StageTop from "StageTop"

describe("totalCount", () => {
  it("合計予約枚数が取得できること", () => {
    const localThis = {
      tickets: [
        { count: 1 },
        { count: 2 },
        { count: 3 }
      ]
    }

    expect(StageTop.computed.totalCount.call(localThis)).toBe(6)
  });
});

describe("countPerSchedule", () => {
  it("日程別の予約枚数が取得できること", () => {
    const wrapper = shallowMount(StageTop, {
      propsData: {
        tickets: [
          { schedule_id: 1, count: 1 },
          { schedule_id: 1, count: 2 },
          { schedule_id: 3, count: 3 },
        ]
      }
    })

    expect(wrapper.vm.countPerSchedule(1)).toBe(3)
  });
});

describe("searchTickets", () => {
  const tickets_data = [
    { customer_name: "テスト タロウ" },
    { customer_name: "テスト ジロウ" }
  ]

  it("一致する顧客名が取得できること", () => {
    const localThis = {
      tickets: tickets_data,
      keyword: "テスト タロウ"
    }

    expect(StageTop.computed.searchTickets.call(localThis)).toEqual(
      [{ customer_name: "テスト タロウ" }]
    )
  });

  it("未入力の場合は空の配列が返ること", () => {
    const localThis = {
      tickets: tickets_data,
      keyword: ""
    }

    expect(StageTop.computed.searchTickets.call(localThis)).toEqual([])
  });

  it("一致しない場合は場合は空の配列が返ること", () => {
    const localThis = {
      tickets: tickets_data,
      keyword: "てすと いない"
    }
    expect(StageTop.computed.searchTickets.call(localThis)).toEqual([])
  });
})

describe("setScheduleColor", () => {
  const wrapper = shallowMount(StageTop, {
    propsData: {
      tickets: []
    }
  });

  it("15時より前の場合はmatineeとなること", () => {
    expect(wrapper.vm.setScheduleColor("14:59")).toBe("schedule-matinee")
  });

  it("15時以降の場合はsoireeとなること", () => {
    expect(wrapper.vm.setScheduleColor("15:00")).toBe("schedule-soiree")
  });
});

describe("countRank", () => {
  const wrapper = shallowMount(StageTop, {
    propsData: {
      tickets: []
    }
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
