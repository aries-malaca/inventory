export const suppliers = {
    namespaced: true,
    state: {
        suppliers: []
    },
    actions:{
        fetchSuppliers(context) {
            axios.get('/api/supplier/getSuppliers')
                .then(function (response) {
                    context.commit('updateSuppliers', response.data);
                })
        }
    },
    getters:{
        activeSuppliers(state){
            return state.suppliers.filter((supplier)=>{
                return supplier.is_active === 1;
            });
        },
        inactiveSuppliers(state){
            return state.suppliers.filter((supplier)=>{
                return supplier.is_active === 0;
            });
        }
    },
    mutations:{
        updateSuppliers(state, suppliers){
            state.suppliers = suppliers;
        },
    }
};