export const products = {
    // This makes your getters, mutations, and actions accessed by, eg: 'myModule/myModularizedNumber' instead of mounting getters, mutations, and actions to the root namespace.
    namespaced: true,
    state: {
        products: [],
        prices: [],
        categories: [],
        units: [],
    },
    actions:{
        fetchProducts(context){
            axios.get('/api/product/getProducts')
                .then(function (response) {
                    context.commit('updateProducts', response.data);
                })
        },
        fetchPrices(context){
            axios.get('/api/product/getPrices')
                .then(function (response) {
                    context.commit('updatePrices', response.data);
                })
        },
        fetchCategories(context){
            axios.get('/api/product/getCategories')
                .then(function (response) {
                    context.commit('updateCategories', response.data);
                })
        },
        fetchUnits(context){
            axios.get('/api/product/getUnits')
                .then(function (response) {
                    context.commit('updateUnits', response.data);
                })
        }
    },
    getters:{
        activeProducts(state){
            return state.products.filter(function(item){
                return item.is_active === 1;
            });
        },
        inactiveProducts(state){
            return state.products.filter(function(item){
                return item.is_active === 0;
            });
        }
    },
    mutations:{
        updateProducts(state, products){
            state.products = products;
        },
        updatePrices(state, prices){
            state.prices = prices;
        },
        updateCategories(state, categories){
            state.categories = categories;
        },
        updateUnits(state, units){
            state.units = units;
        }
    }
};