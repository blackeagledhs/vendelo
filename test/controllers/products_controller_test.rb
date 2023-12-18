require 'test_helper'
class ProductsControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path

        assert_response :success
        assert_select '.product', 2
    end

    test 'render a detailed product page' do
        get product_path(products(:ps4))

        assert_response :success
        assert_select '.title', 'Ps4'
        assert_select '.description', 'problema en lectora'
        assert_select '.price', '$150'
    end

    test 'render a new product form' do 
        get new_prduct_path
        
        assert_response :success
        assert_select 'form'
    end

    test 'allow to create new product' do
        post products_path, params: {
            product: {
                title: 'Nintendo',
                description: 'anda perfect',
                price: 100
            }
        }

        assert_redirected_to products_path
    end
end