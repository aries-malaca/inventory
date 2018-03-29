export const users = {
    namespaced: true,
    state: {
        users: []
    },
    actions:{
        fetchUsers(context) {
            axios.get('/api/user/getUsers')
                .then(function (response) {
                    context.commit('updateUsers', response.data);
                })
        }
    },
    getters:{
        activeUsers(state){
            return state.users.filter((user)=>{
                return user.is_active === 1;
            });
        },
        inactiveUsers(state){
            return state.users.filter((user)=>{
                return user.is_active === 0;
            });
        }
    }
};