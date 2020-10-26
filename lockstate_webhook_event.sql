select body.data.attributes.occurred_at as when_, body.data.attributes.publisher_id as who_, body.data.attributes.pin as id from lockstate_webhook_events
