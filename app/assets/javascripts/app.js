/* global Vue, moment, $ */
document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: "#app",
    data: function() {
      return {
        leads: [],
        time_format: "12/25/17",
        url: "https://www.google.com/",
        searchFilter: "",
        sorted: {
          created: false,
          first_name: false,
          last_name: false,
          email: false,
          phone: false,
          appointment_date: false
        },
        count: 50,
        loading: false,
        loaded: false
      };
    },
    mounted: function() {
      $.get("/api/v1/leads.json?count=" + this.count).success(
        function(response) {
          this.leads = response;
        }.bind(this)
      );
    },
    methods: {
      moment: function(date) {
        return moment(date);
      },
      columnSort: function(column) {
        var test = this.sorted[column];
        this.leads = this.leads.sort(function(lead1, lead2) {
          if (lead1[column] > lead2[column]) {
            return test ? -1 : 1;
          } else {
            return test ? 1 : -1;
          }
        });
        this.sorted[column] = !this.sorted[column];
      },
      accordion: function(leadId) {
        this.leads.forEach(function(lead) {
          if (lead.id === leadId) {
            lead.clicked = !lead.clicked;
            if ($(".accordion-" + lead.id).css("display") !== "none") {
              $(".accordion-" + lead.id).css("display", "none");
            } else {
              $(".accordion-" + lead.id).css("display", "table-row");
            }
          }
        });
      },
      check: function() {},
      loadNew: function() {
        if (!this.loaded) {
          this.count += 50;
          this.loading = true;
          $.get("/api/v1/leads.json?count=" + this.count).success(
            function(response) {
              console.log("Before if");
              if (this.leads.length !== response.length) {
                console.log(this.leads);
                console.log(response);
                this.leads = response;
                this.loading = false;
              } else {
                console.log("True");
                this.loaded = true;
              }
            }.bind(this)
          );
        }
      }
    },
    computed: {
      filteredList() {
        return this.leads.filter(lead => {
          return (
            lead.first_name
              .toLowerCase()
              .includes(this.searchFilter.toLowerCase()) ||
            lead.last_name
              .toLowerCase()
              .includes(this.searchFilter.toLowerCase()) ||
            lead.email.toLowerCase().includes(this.searchFilter.toLowerCase())
          );
        });
      }
    }
  });

  $(window).scroll(function() {
    if ($(window).scrollTop() + $(window).height() == $(document).height()) {
      app.loadNew();
      // console.log(app);
      // console.log("bottom");
    }
  });
});
