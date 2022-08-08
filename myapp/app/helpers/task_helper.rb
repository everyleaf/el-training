module TaskHelper
    # コード→表示文言変換
    def get_status_view(code)
        # 該当するコードを検索し、表示文言返却
        Task::STATUS_VIEW.keys.each do |key|
            puts 'code::'
            puts Task.statuses[code]
            puts 'value[code]'
            puts key
            if Task.statuses[code] == key then
                return Task::STATUS_VIEW[key]
            end
        end

        return ""
    end
end
