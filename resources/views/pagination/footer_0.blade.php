<button v-bind:disabled="pagination[0].current_page==1" class="btn btn-sm"
@click="setPage(pagination[0].current_page - 1,0)">
Previous
</button>
<button v-bind:disabled="pagination[0].current_page==Math.ceil(pagination[0].original_length/pagination[0].per_page) || pagination[0].original_length==0"
@click="setPage(pagination[0].current_page + 1,0)" class="btn btn-sm">
Next
</button><br/><br/>
<span v-text=" 'Showing ' + pagination[0].current_page + ' Page of ' + Math.ceil(pagination[0].original_length/pagination[0].per_page) + ' of ' + pagination[0].original_length + ' entries'"></span>
