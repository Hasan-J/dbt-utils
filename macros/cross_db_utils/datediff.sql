{% macro datediff(first_date, second_date, datepart) %}
    {% if datepart == 'year' %}

        DATE_PART('year', {{ second_date }}) - DATE_PART('year', {{ first_date }})

    {% elif datepart == 'month' %}

        ( DATE_PART('year', {{ second_date }}) - DATE_PART('year', {{ first_date }}) ) * 12
            + DATE_PART('month', {{ second_date }}) - DATE_PART('month', {{ first_date }})

    {% elif datepart == 'day' %}

        {{ second_date }} - {{ first_date }}

    {% elif datepart == 'week' %}

        FLOOR ( ({{ second_date }} - {{ first_date }}) / 7 )

    {% elif datepart == 'hour' %}

        ( {{ second_date }} - {{ first_date }} ) * 24
            + DATE_PART('hour', {{ second_date }}) - DATE_PART('hour', {{ first_date }})

    {% elif datepart == 'minute' %}

        ( ( {{ second_date }} - {{ first_date }} ) * 24
            + DATE_PART('hour', {{ second_date }}) - DATE_PART('hour', {{ first_date }}) ) * 60
                + DATE_PART('minute', {{ second_date }}) - DATE_PART('minute', {{ first_date }})

    {% elif datepart == 'second' %}

        ( ( ( {{ second_date }} - {{ first_date }} ) * 24
            + DATE_PART('hour', {{ second_date }}) - DATE_PART('hour', {{ first_date }}) ) * 60
                + DATE_PART('minute', {{ second_date }}) - DATE_PART('minute', {{ first_date }}) ) * 60
                    + DATE_PART('second', {{ second_date }}) - DATE_PART('second', {{ first_date }})

    {% endif %}
{% endmacro %}


{% macro default__datediff(first_date, second_date, datepart) %}

    datediff(
        {{ datepart }},
        {{ first_date }},
        {{ second_date }}
        )

{% endmacro %}


{% macro bigquery__datediff(first_date, second_date, datepart) %}

    datetime_diff(
        cast({{second_date}} as datetime),
        cast({{first_date}} as datetime),
        {{datepart}}
    ) 

{% endmacro %}


{% macro postgres__datediff(first_date, second_date, datepart) %}

    {{ exceptions.raise_compiler_error("macro datediff not implemented for this adapter") }}

{% endmacro %}
