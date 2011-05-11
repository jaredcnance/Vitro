<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Template for displaying list of user accounts -->

<form method="POST" action="${formUrl}">

    <#--current page: <input type="text" name="pageIndex" value="${page.current}" />
    <br />-->

    <#--sort order:
    <!-- Manolo: I don't know the right way to handle these links in the column headers. --> 
    <#--<#assign directions = ["ASC", "DESC"]>
    <select name="orderDirection" >
      <#list directions as direction>
        <option value="${direction}" <#if orderDirection = direction>selected</#if> >${direction}</option>
      </#list>
    </select> 
    <!-- When orderDirection changes, 
            set pageIndex to 1 
            submit the form (submit action is "list") --> 
    <#--<br />        -->
    

    <#--sort field:
    <!-- Manolo: I don't know the right way to handle these links in the column headers. --> 
    <#--<#assign fields = ["email", "firstName", "lastName", "status", "count"]>
    <select name="orderField" >
      <#list fields as field>
        <option value="${field}" <#if orderField = field>selected</#if> >${field}</option>
      </#list>
    </select> -->
    
    <!-- When orderField changes, 
            set pageIndex to 1
            set orderDirection to "ASC" 
            submit the form (submit action is "list") --> 
   <!-- <br />
    <input type="submit" name="list" value="Refresh page" />--> 
</form>

<h3>Account  | <input type="submit" name="add" class="submit" value="Add new account" /></h3>
<!-- When this is clicked, all other fields are ignored. -->

<section class="account-feedback">
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. <a hrf="#">Maecenas dui erat</a>, dapibus non vehicula at, tristique eu sem. Suspendisse ligula felis, mollis vitae elementum eget, semper a nisl.</p>
</section>

<section id="filter-roles">
    <select name="roleFilterUri" id="">
        <option value="" <#if roleFilterUri = "">selected</#if> >Filter by roles</option>
        <#list roles as role>
        <option value="${role.uri}" <#if roleFilterUri = role.uri>selected</#if> >${role.label}</option>
        </#list>
        <!--
        When roleFilterUri or searchTerm changes,
        pageIndex should be set to 1. When any of these changes (including pageIndex), the form 
        should be submitted.
        -->
    </select>
</section>

<section id="search-accounts">
    <input type="text" name="" />
    <input class="submit" type="submit" value="Search accounts"/>
    <!--
        When searchTerm changes, 
        set pageIndex to 1
        set orderDirection to "ASC"
        set orderField to "email" 
        submit the form (submit action is "list") 
    -->
</section>

<section class="accounts">
    <input type="submit" name="delete" class="submit delete-account" value="Delete" />
    <!-- When this is clicked, the checkboxes are noticed and all other fields are ignored. -->

    <nav class="display-tools">
        <span>| <a href="#">n</a> accounts | </span>  

        <form method="get" class="accounts-per-page-form" name="list" action="${formUrl}">
            
            <#assign counts = [25, 50, 100]>
            <select name="accountsPerPage" class="accounts-per-page">
                <#list counts as count>
                <option value="${count}" <#if accountsPerPage= count>selected</#if> >${count}</option>
                </#list>
                <!-- 
                    When accountsPerPage changes, 
                    set pageIndex to 1 
                    submit the form (submit action is "list") 
                -->     
            </select>

            <input class="hide" type="submit" value="Update" />
        </form>

        accounts per page | 

        <#if page.previous?has_content>
            <a href="${formUrl}?accountsPerPage=${accountsPerPage}&pageIndex=${page.previous}">Previous</a> <!-- only present if current page is not 1.-->
        </#if>
            ${page.current} of ${page.last} 
        <#if page.next?has_content>
            <a href="${formUrl}?accountsPerPage=${accountsPerPage}&pageIndex=${page.next}">Next</a><!-- only present if current page is not last page.-->
        </#if>
    </nav>
</section>

<table id="account">
    <caption>Account Management</caption>

    <thead>
        <tr>
            <th scope="col">
                <div>
                    <form method="get" class="delete-all-accounts" name="list" action="${formUrl}">
                        <input class="hide" type="checkbox" name="delete-all" id="">Email Address<span></span>
                    </form>
                </div>
            </th>
            <th scope="col"><div>First name <a href="?accountsPerPage=${accountsPerPage}&orderField=firstName&orderDirection=ASC"><img class="middle" src="${urls.themeImages}/sort-asc.gif" /></a> <a href="?accountsPerPage=${accountsPerPage}&orderField=firstNameorderDirection=DEC"><img src="${urls.themeImages}/sort-desc.gif" /></a></div></th>
            <th scope="col"><div>Last Name<span></span></div></th>
            <th scope="col"><div>Status<span></span></div></th>
            <th scope="col"><div>Roles</div></th>
            <th scope="col"><div>Login Count<span></span></div></th>
        </tr>
    </thead>

    <tbody>
        <#list accounts as account>
            <tr>
                <td>
                    <input type="checkbox" name="deleteAccount" value="${account.uri}" />
                    <!-- ignored unless submit action is "delete" -->

                    <a href="${formUrl}?edit&editAccount=${account.uri}" >${account.emailAddress}</a>
                    <!-- if submit action is "edit", editAccount is noticed and all other fields are ignored. -->
                </td>
                <td>${account.firstName}</td>
                <td>${account.lastName}</td>
                <td>${account.status}</td>
                <td>
                    <#list account.permissionSets as permissionSet>
                        <div>${permissionSet}</div>
                    </#list>
                </td>
                <td>${account.loginCount}</td>
            </tr>
        </#list>
    </tbody>
</table>

<#--link on user's email address currently does nothing-->

${scripts.add('<script type="text/javascript" src="${urls.base}/js/account/accountUtils.js"></script>')}