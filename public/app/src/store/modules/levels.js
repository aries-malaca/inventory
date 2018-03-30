export const levels = {
    namespaced: true,
    state: {
        levels: []
    },
    mutations:{
    	updateLevels(state, levels){
    		state.levels = levels;
    	}
    }
};