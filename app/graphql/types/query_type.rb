module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :dynamic_plan_execution, [Types::DynamicPlanExecutionType], null: false do
      argument :year, String, required: true
      description "Query that retrieves data for sales plan execution dynamic report"
    end

    field :dynamic_indexed_sales, [Types::DynamicIndexedSalesType], null: false do
      argument :year, String, required: true
      description "Query that retrieves data for product turnover in indexed prices report"
    end

    field :product_group_structure, GraphQL::Types::JSON, null: false do
      argument :year, String, required: true
      description "Query that retrieves data for product group's sales spreading report"
    end

    field :payment_method_structure, GraphQL::Types::JSON, null: false do
      argument :year, String, required: true
      description "Query that retrieves data for sales's payment method spreading report"
    end

    field :trade_form_structure, GraphQL::Types::JSON, null: false do
      argument :year, String, required: true
      description "Query that retrieves data for sales's trade form spreading report"
    end

    field :seasonality_structure, GraphQL::Types::JSON, null: false do
      argument :year, String, required: true
      description "Query that retrieves data for seasonality spreading report"
    end

    field :average_prices_structure, [Types::AveragePriceInMonthType], null: false do
      argument :year, String, required: true
      description "Query that retrieves data for average prices report"
    end




    def dynamic_plan_execution(year:)
      get_months_of_specific_year(year)
    end

    def dynamic_indexed_sales(year:)
      get_months_of_specific_year(year)
    end

    def product_group_structure(year:)
      ProductGroup.all.map {|pg| [pg.name, pg.sales_sum_by_year(year)] }
    end

    def payment_method_structure(year:)
      [ ["Наличный расчет" ,Sale.of_specific_year(year).in_cash.count], ["Эл. перевод", Sale.of_specific_year(year).in_transaction.count] ]
    end

    def trade_form_structure(year:)
      [ ["Оптовые продажи" ,Sale.of_specific_year(year).is_wholesale.count], ["Продажи в розницу", Sale.of_specific_year(year).is_retail.count] ]
    end

    def seasonality_structure(year:)
      [
        ["1", get_sales_for_specific_season_and_year(year, [1,3]  )  ],
        ["2",  get_sales_for_specific_season_and_year(year, [4,6]  ) ],
        ["3", get_sales_for_specific_season_and_year(year, [7,9]  )   ],
        ["4", get_sales_for_specific_season_and_year(year, [10,12]  ) ]
      ]
    end

    def average_prices_structure(year:)
        get_months_of_specific_year(year)
    end



    # helper methods
    def get_months_of_specific_year(year)
        Month.of_specific_year(year)
    end

    def get_sales_for_specific_season_and_year(year, season_start_end_month_n)
        Month.where(date: ( Date.parse("1-#{season_start_end_month_n[0]}-#{year}").end_of_month .. Date.parse("1-#{season_start_end_month_n[1]}-#{year}").end_of_month )).to_a.sum(&:sales_sum_indexed)
    end


  end
end