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
          query: {
            ranges: ranges.join(','),
            dateTimeRenderOption: 'FormattedString',
          },
        )
      end

      def values_prepend(spreadsheet_token, value_range)
        post(
          "/sheets/v2/spreadsheets/#{spreadsheet_token}/values_prepend",
          body: { "valueRange": value_range },
        )
      end

      def sheets_batch_update(spreadsheet_token, requests)
        post(
          "/sheets/v2/spreadsheets/#{spreadsheet_token}/sheets_batch_update",
          body: { requests: requests },
        )
      end
    end
  end
end
