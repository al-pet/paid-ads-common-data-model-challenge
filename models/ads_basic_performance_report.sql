{{
    config(        
        materialized='table'
    )
}}

with 
              
    structured_table as (           --creates structured view (temporary table), uniting selected raw data from all sourses (ads platforms), model needs.

    -- MODEL ADD EXAMPLE===============================
        -- select 
        --         channel as channel,
        --         spend as spend,
        --         purchase as purchase,
        --         clicks + comments + likes + shares + views + etc as engagements,
        --         impressions as impressions,
        --         clicks as clicks
        -- from {{ ref('example_data')}}
        
        -- UNION ALL    

    -- BING===============================
        select 
            channel,
            spend,
            conv as purchase,
            NULL as engagements,
            NULL as impressions,
            clicks
        from {{ ref('src_ads_bing_all_data')}}

        UNION ALL

     -- FACEBOOK===============================
        select 
                channel,
                spend,
                purchase,
                clicks + comments + likes + shares + views as engagements,
                impressions,
                clicks
        from {{ ref('src_ads_creative_facebook_all_data')}}
        
        UNION ALL

    --  TIKTOK===============================
        select 
            channel,
            spend,
            conversions as purchase,
            clicks + video_views as engagements,
            impressions,
            clicks
        from {{ ref('src_ads_tiktok_ads_all_data')}}

        UNION ALL

    --  TWITTER===============================
        select 
            channel,
            spend,
            video_total_views as purchase,
            engagements,
            impressions,
            clicks
        from {{ ref('src_promoted_tweets_twitter_all_data')}}

    )        
       
select           --transforms raw data to metrics
    channel,
    round(sum(spend)/sum(purchase)) as conversion_cost,
    round(sum(spend)/sum(engagements), 2) as engagement_cost,
    sum(impressions) as impressions,
    round(sum(spend)/sum(clicks), 2) as cpc
from structured_table
group by channel