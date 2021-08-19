class PagesController < ApplicationController

        def home

       end

       def index
         @dynamic_indexed_chart = []

          Month.of_specific_year(params[:year]).each do |m|
            @dynamic_indexed_chart << [m.russian_name_of_month, m.sales_sum_indexed]
          end

          @product_group_data = ProductGroup.all.map {|pg| [pg.name, pg.sales_sum_by_year(params[:year])] }

          @average_price_chart = []
          Month.of_specific_year(params[:year]).each do |m|
            @average_price_chart << [m.russian_name_of_month, m.average_sales_price]
          end

          @current_year = params[:year]

       end

       def dynamic_plan_execution

         @dynamic_plan_chart = []
         @dynamic_plan_data = []

         Month.of_specific_year(params[:year]).each do |m|
           @dynamic_plan_chart << [m.russian_name_of_month, m.sales_sum_indexed]
            @dynamic_plan_data << [
              m.month_number,
              m.russian_name_of_month,
              m.sales_plan,
              m.sales_sum,
              (m.plan_compl_percent*100).round(2)
            ]
         end


         @current_year = params[:year]
       end

       def dynamic_indexed_sales
         @chart = []
         @data = []

         Month.of_specific_year(params[:year]).each do |m|
           @chart << [m.russian_name_of_month, m.sales_sum_indexed]
            @data << [
              m.month_number,
              m.russian_name_of_month,
              m.sales_sum,
              m.price_index,
              m.sales_sum_indexed,
              m.growth_rate_percent,
              m.rate_of_increase_percent
            ]
         end

            @current_year = params[:year]
       end

       def product_group_structure
         @chart = []
         @data = []

         @chart = ProductGroup.all.map {|pg| [pg.name, pg.sales_sum_by_year(params[:year])] }
          @data = @chart

         @current_year = params[:year]
       end

       def payment_method_sctructure
         @data = [ ["Наличный расчет" ,Sale.of_specific_year(params[:year]).in_cash.count], ["Эл. перевод", Sale.of_specific_year(params[:year]).in_transaction.count] ]
        @current_year = params[:year]


       end

       def trade_form_sctructure
         @data =   [ ["Оптовые продажи" ,Sale.of_specific_year(params[:year]).is_wholesale.count], ["Продажи в розницу", Sale.of_specific_year(params[:year]).is_retail.count] ]
          @current_year = params[:year]
       end

       def seasonality_sctructure
         @data = [
           ["1 квартал", get_sales_for_specific_season_and_year(params[:year], [1,3]  )  ],
           ["2 квартал",  get_sales_for_specific_season_and_year(params[:year], [4,6]  ) ],
           ["3 квартал", get_sales_for_specific_season_and_year(params[:year], [7,9]  )   ],
           ["4 квартал", get_sales_for_specific_season_and_year(params[:year], [10,12]  ) ]
         ]
         @current_year = params[:year]
       end

       def average_prices
         @chart = []
         @data = []
         Month.of_specific_year(params[:year]).each do |m|
            @chart << [m.russian_name_of_month, m.average_sales_price]
             @data << [
               m.month_number,
               m.russian_name_of_month,
               m.average_sales_price
             ]
         end


         @current_year = params[:year]
       end

       def abs_product_analysis
         @data = abc_product_analysis(params[:year])
         @current_year = params[:year]
       end

       private

       def get_sales_for_specific_season_and_year(year, season_start_end_month_n)
           Month.where(date: ( Date.parse("1-#{season_start_end_month_n[0]}-#{year}").end_of_month .. Date.parse("1-#{season_start_end_month_n[1]}-#{year}").end_of_month )).to_a.sum(&:sales_sum_indexed)
       end

       def abc_product_analysis(year)
         total_sales_sum_by_year = Sale.of_specific_year_to_array(year).sum(&:total_sum)

         product_ordered_by_sales =  Product.all.to_a.sort { |a,b|  a.sales_sum_by_year(year) <=> b.sales_sum_by_year(year)   }
         product_ordered_by_sales = product_ordered_by_sales.reverse()
         additional_part = 0.0
         abc_product_data = []

         product_ordered_by_sales.each_with_index do |p, idx|
             sales_sum_product = p.sales_sum_by_year(year)
             part = sales_sum_product.to_f/total_sales_sum_by_year.to_f
             additional_part += part

             case additional_part
             when 0.0 .. 0.7
                 group = "A"
               when 0.7 .. 0.95
                 group = "B"
               when 0.95 .. 100.0
                 group = "C"
             end

             abc_product_data << [idx+1, p.name, sales_sum_product , (part.round(2))*100,additional_part.round(1), group]
           end

           abc_product_data
       end


end
