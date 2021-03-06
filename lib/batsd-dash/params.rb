# helpers for processing params and validating input
module BatsdDash
  module ParamsHelper
    def parse_metrics
      metrics = params[:metrics]
      metrics = [metrics] unless Array === metrics

      metrics.tap { |list| list.reject! { |m| m.nil? || m.empty? } }
    end

    def parse_time_range
      start, stop = params[:start], params[:stop]

      if start.nil? && stop.nil?
        now = Time.now.to_i

        # 1 hr range
        # TODO make this setting?
        [ now - 3600 + 1, now ]

      else
        [start.to_i, stop.to_i].tap do |range|
          if range[0] <= 0 || range[1] <= 0 || range[0] >= range[1]
            return nil
          end
        end
      end
    end
  end
end
