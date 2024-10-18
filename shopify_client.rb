require 'shopify_api'

class ShopifyClient


  def initialize(shop_url, access_token)
    session = ShopifyAPI::Auth::Session.new(
        shop: shop_url,
        access_token: access_token)

    @client = ShopifyAPI::Clients::Graphql::Admin.new(session: session)
  end

  def fetch_metafields
    objects = ['product', 'product_variant', 'collection', 'customer','order', 'draft_order', 'company', 'company_location', 'location', 'page', 'blog', 'market']
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
            metafieldDefinitions(ownerType: MARKET first: 10) {
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
