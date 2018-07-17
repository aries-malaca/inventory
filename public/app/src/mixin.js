export const mixin = {
    methods: {
        gate(user, permission, action){
            if(user.level === 1)
                return true;

            if(user.level_data === undefined)
                return false;

            if(user.level_data.permissions[permission] === undefined)
                return false;

            return user.level_data.permissions[permission].indexOf(action) !== -1;
        },
        moment:moment
    }
};