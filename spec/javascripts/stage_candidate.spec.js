import StageCandidate from "StageCandidate"

describe("searchCustomers", () => {
  // 入力が合った場合はstore/gettersのテストとする
  it("未入力の場合は全ての顧客を取得すること", () => {
    const localThis = {
      customers: [
        { name: "テスト タロウ" },
        { name: "テスト ジロウ" }
      ],
      keyword: ""
    }

    expect(StageCandidate.computed.searchCustomers.call(localThis)).toEqual(
      [
        { name: "テスト タロウ" },
        { name: "テスト ジロウ" }
      ]
    )
  });
});
