import StageTicket from "StageTicket";

describe("searchTickets", () => {
  // 入力があった場合はstore/gettersのテストとする
  it("未入力の場合は顧客名が表示されていること", () => {
    const localThis = {
      tickets: [
        { customer_name: "テスト タロウ"},
        { customer_name: "テスト ジロウ"}
      ],
      keyword: ""
    }

    expect(StageTicket.computed.searchTickets.call(localThis)).toEqual(
      [
        { customer_name: "テスト タロウ" },
        { customer_name: "テスト ジロウ" }
      ]
    )
  });
});
