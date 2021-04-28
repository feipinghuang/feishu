module Feishu
  module Api
    module Sheets
      def metainfo(spreadsheet_token)
        get("/sheets/v2/spreadsheets/#{spreadsheet_token}/metainfo")
      end

      def values(spreadsheet_token, range)
        get("/sheets/v2/spreadsheets/#{spreadsheet_token}/values/#{range}")
      end

      def values_batch_get(spreadsheet_token, ranges)
        get(
          "/sheets/v2/spreadsheets/#{spreadsheet_token}/values_batch_get",
          query: { ranges: ranges.join(',') },
        )
      end
    end
  end
end
