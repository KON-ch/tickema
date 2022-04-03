import { getters } from "store/getters"

describe("getters", () => {
  const state = {
    tickets: [
      { customer_name: "テスト タロウ", count: 1, schedule_id: 1 },
      { customer_name: "テスト ジロウ", count: 2, schedule_id: 1 },
      { customer_name: "てすと はなこ",  count: 3, schedule_id: 2 }
    ],
    candidates: [
      { name: "サンプル タロウ" },
      { name: "サンプル ジロウ" }
    ]
  };

  it("totalCount", () => {
    expect(getters.totalCount(state)).toBe(6)
  });

  it("countPerSchedule", () => {
    expect(getters.countPerSchedule(state)(1)).toBe(3)
  })

  it("searchTickets", () => {
    expect(getters.searchTickets(state)("テスト")).toEqual(
      [
        { customer_name: "テスト タロウ", count: 1, schedule_id: 1 },
        { customer_name: "テスト ジロウ", count: 2, schedule_id: 1 }
      ]
    );

    expect(getters.searchTickets(state)("サンプル")).toEqual([])
  })

  it("searchCustomers", () => {
    expect(getters.searchCustomers(state)("タロウ")).toEqual([{ name: "サンプル タロウ" }])
  });
})
