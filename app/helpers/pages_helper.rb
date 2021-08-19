module PagesHelper
  def list_years
      Month.all.to_a.uniq{|m| m.date.year }.map{|m_uniq_year| m_uniq_year.date.year}
  end

  def reportsList
    [
      ["Динамика выполнения плана продаж", "dynamic_plan_execution"],
      ["Динамика товарооборота в сопоставимых ценах", "dynamic_indexed_sales"],
      ["Товарно-групповая структура товарооборота", "product_group_structure"],
      ["Структура товарооборота по формам оплаты", "payment_method_sctructure"],
      ["Структура товарооборота по формам торговли", "trade_form_sctructure"],
      ["Сезонность товарооборота", "seasonality_sctructure"],
      ["Средняя цена реализации товаров" , "average_prices"] ]
  end
end
