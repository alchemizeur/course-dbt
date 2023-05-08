-- macros/product_view_filter.sql

{% macro product_view_filter() %}
  event_type = 'page_view' AND page_url_type = 'product'
{% endmacro %}