export const clients = {
    namespaced: true,
    state: {
        clients: []
    },
    actions: {
        fetchClients(context) {
            axios.get('/api/client/getClients')
                .then(function (response) {
                    context.commit('updateClients', response.data);
                })
        }
    },
    mutations:{
        updateClients(state, clients){
            state.clients = clients;
        },
    },
    getters:{
        activeClients(state){
            return state.clients.filter((client)=>{
               return client.is_active === 1;
            });
        },
        inactiveClients(state){
            return state.clients.filter((client)=>{
                return client.is_active === 0;
            });
        }
    }
};