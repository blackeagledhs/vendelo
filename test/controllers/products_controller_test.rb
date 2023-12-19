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
        get new_product_path
        
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
        assert_equal flash[:notice], 'Tu producto se ha guardado correctamente'
    end

    test 'does not allow to create new product with empty field' do
        post products_path, params: {
            product: {
                title: '',
                description: 'anda perfect',
                price: 100
            }
        }

        assert_response :unprocessable_entity
    end    

    test 'render an edit product form' do 
        get edit_product_path(products(:ps4))
        
        assert_response :success
        assert_select 'form'
    end

    test 'allow to update a product' do
        patch product_path(products(:ps4)), params: {
            product: {
               
                price: 165
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Producto actualizado correctamente'
    end
end