require 'shopify_api'

class ShopifyClient


  def initialize(shop_url, access_token)
    session = ShopifyAPI::Auth::Session.new(
        shop: shop_url,
        access_token: access_token)

    @client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)
  end

  def fetch_metafields
    objects = ['product', 'product_variant', 'collection', 'customer', 'order', 'draft_order', 'company', 'company_location', 'location', 'page', 'blog', 'market', 'payment_customization', 'validation', 'delivery_customization', 'gift_card_transaction', 'cart_transform', 'media_image', 'selling_plan', 'article', 'fulfillment_constraint_rule', 'order_routing_location_rule', 'discount', 'shop']
    metafields = []
    objects.each do |object|
      puts "Fetching #{object} metafields..."
      metafields << self.send("#{object}_metafields")
    end

    objects.zip(metafields).to_h
  end

  def fetch_metaobjects
    query = <<~QUERY
        query MetaobjectDefinitions {
            metaobjectDefinitions(first: 100) {
                nodes {
                    id
                    name
                    type
                    fieldDefinitions {
                        key
                        name
                        required
                        type {
                            category
                            name
                        }
                    }
                    metaobjects(first: 10) {
                        nodes {
                            displayName
                            handle
                            id
                            type
                            updatedAt
                        }
                    }
                }
                edges {
                    node {
                        description
                        displayNameKey
                        hasThumbnailField
                        id
                        metaobjectsCount
                        name
                        type
                        fieldDefinitions {
                            description
                            key
                            name
                            required
                        }
                    }
                }
            }
        }
    QUERY
    @client.query(query: query).body['data']['metaobjectDefinitions']['nodes']
  end


  private

  def product_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: PRODUCT, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def product_variant_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: PRODUCTVARIANT, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def collection_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: COLLECTION, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def customer_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: CUSTOMER, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def order_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: ORDER, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def draft_order_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: DRAFTORDER, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def company_metafields
    query = <<~QUERY
    query MetafieldDefinitions {
        metafieldDefinitions(ownerType: COMPANY, first: 10) {
            nodes {
                name
                type {
                    category
                    name
                    supportsDefinitionMigrations
                    valueType
                }
            }
            edges {
                node {
                    description
                    id
                    key
                    metafieldsCount
                    name
                    namespace
                    ownerType
                    pinnedPosition
                    useAsCollectionCondition
                    validationStatus
                    visibleToStorefrontApi
                }
            }
        }
    }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def company_location_metafields
     query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: COMPANY_LOCATION, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def location_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: LOCATION, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def page_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: PAGE, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def blog_metafields
    query = <<~QUERY
        query MetafieldDefinitions {
            metafieldDefinitions(ownerType: BLOG, first: 10) {
                nodes {
                    name
                    type {
                        category
                        name
                        supportsDefinitionMigrations
                        valueType
                    }
                }
                edges {
                    node {
                        description
                        id
                        key
                        metafieldsCount
                        name
                        namespace
                        ownerType
                        pinnedPosition
                        useAsCollectionCondition
                        validationStatus
                        visibleToStorefrontApi
                    }
                }
            }
        }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def market_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: MARKET, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def payment_customization_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: PAYMENT_CUSTOMIZATION, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def validation_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: VALIDATION, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def delivery_customization_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: DELIVERY_CUSTOMIZATION, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def gift_card_transaction_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: GIFT_CARD_TRANSACTION, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def cart_transform_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: CARTTRANSFORM, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def media_image_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: MEDIA_IMAGE, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def selling_plan_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: SELLING_PLAN, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def article_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: ARTICLE, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def fulfillment_constraint_rule_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: FULFILLMENT_CONSTRAINT_RULE, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def order_routing_location_rule_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: ORDER_ROUTING_LOCATION_RULE, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def discount_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: DISCOUNT, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

  def shop_metafields
    query = <<~QUERY
      query MetafieldDefinitions {
        metafieldDefinitions(ownerType: SHOP, first: 10) {
          nodes {
            name
            type {
              category
              name
              supportsDefinitionMigrations
              valueType
            }
          }
          edges {
            node {
              description
              id
              key
              metafieldsCount
              name
              namespace
              ownerType
              pinnedPosition
              useAsCollectionCondition
              validationStatus
              visibleToStorefrontApi
            }
          }
        }
      }
    QUERY

    @client.query(query: query).body['data']['metafieldDefinitions']['nodes']
  end

end
